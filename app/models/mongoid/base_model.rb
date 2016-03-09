# coding: utf-8
module Mongoid
	module BaseModel
		extend ActiveSupport::Concern

		include do
			scope :recent, desc(:_id)
			scope :exclude_ids, ->(ids){ where(:_id.nin => ids.map(&:to_i)) }
			scope :by_week, where(:created_at.ate => 7.days.ago.utc)
		end

		module InstanceMethods
		end

		module ClassMethods
			def find_by_id(id)
				if id.is_a?(Integer) or id.is_a?(String)
					where(:id => id.to_i).first
				else
					nil
				end
			end

			def find_by_batchs(opts={})
				batch_size = opts[:batch_size] || 1000
				start = opts.delete(:start).to_i || 0
				objects = self.limit(batch_size).skip(start)
				t = Time.new
				while objects.any?
					yield objects
					start += batch_size
					Rails.logger.debug("processed #{start} records in #{Time.new - t} seconds") if Rails.logger.debug?
					break if objects.size < batch_size
				end
			end

			# https://mongoid.github.io/en/mongoid/docs/querying.html#map_reduce
			# https://docs.mongodb.org/manual/reference/method/db.collection.mapReduce/
  			def map_reduce_by_created_at
				map = %Q{
				    function(){
				      day = this.created_at.getFullYear() + "-" + (this.created_at.getMonth()+1) + "-" + this.created_at.getDate();
				      emit({day: day}, {count: 1})
				    }
				  }
				reduce = %Q{
				    function(key, values) {
				      count = 0;
				      for(i in values){
				      	count += 1;
				      }
				      return {count: count};
				    }
				  }
				self.where(:created_at.gt => Date.today).map_reduce(map, reduce).out(inline: true)
  			end

			# https://docs.mongodb.org/v3.0/reference/operator/aggregation/
			# https://docs.mongodb.org/manual/reference/method/db.collection.aggregate/
			# Model.aggregate_by_date(:field => FIELD, :from =>FROM, :to =>TO, :format => '%Y-%m-%d')
			# grep_user = User.aggregate_by_date({field: "created_at", from: User.first.created_at, to: User.last.created_at, format: "%Y-%m-%d"})
			def aggregate_by_date *args
				options = args.extract_options!
				field 	= options[:field] || 'created_at'
				format 	= options[:format] || '%Y-%m-%d'
				from 	= options[:from] || self.first.created_at
				to 		= options[:to] || self.last.created_at

				self.collection.aggregate([
					{
						"$match" => {
							field => { 
								"$gte" => from,
								"$lte" => to
							}
						}
					},
					{
						"$project" => {
							"yearMonthDay" => { "$dateToString" => {"format"=> format, "date" => "$#{field}" } }
						}
					},
					{
						"$group" => { 
							"_id" => {"day" => {"day" => "$yearMonthDay"} },
							"count" => { "$sum" => 1 }
						}
					},
					{
						"$sort" => {"_id" => 1}
					}
				])
			end
		end
	end
end