# ===================================================================================================
#                           _  __     _ _
#                          | |/ /__ _| | |_ _  _ _ _ __ _
#                          | ' </ _` | |  _| || | '_/ _` |
#                          |_|\_\__,_|_|\__|\_,_|_| \__,_|
#
# This file is part of the Kaltura Collaborative Media Suite which allows users
# to do with audio, video, and animation what Wiki platfroms allow them to do with
# text.
#
# Copyright (C) 2006-2019  Kaltura Inc.
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <http:#www.gnu.org/licenses/>.
#
# @ignore
# ===================================================================================================
require 'kaltura_client.rb'

module Kaltura

	class KalturaConfMapsStatus
		STATUS_DISABLED = 0
		STATUS_ENABLED = 1
	end

	class KalturaConfMaps < KalturaObjectBase
		# Name of the map
		attr_accessor :name
		# Ini file content
		attr_accessor :content
		# IsEditable - true / false
		attr_accessor :is_editable
		# Time of the last update
		attr_accessor :last_update
		# Regex that represent the host/s that this map affect
		attr_accessor :related_host
		attr_accessor :version
		attr_accessor :source_location
		attr_accessor :remarks
		# map status
		attr_accessor :status

		def is_editable=(val)
			@is_editable = to_b(val)
		end
		def last_update=(val)
			@last_update = val.to_i
		end
		def version=(val)
			@version = val.to_i
		end
		def status=(val)
			@status = val.to_i
		end

		def from_xml(xml_element)
			super
			if xml_element.elements['name'] != nil
				self.name = xml_element.elements['name'].text
			end
			if xml_element.elements['content'] != nil
				self.content = xml_element.elements['content'].text
			end
			if xml_element.elements['isEditable'] != nil
				self.is_editable = xml_element.elements['isEditable'].text
			end
			if xml_element.elements['lastUpdate'] != nil
				self.last_update = xml_element.elements['lastUpdate'].text
			end
			if xml_element.elements['relatedHost'] != nil
				self.related_host = xml_element.elements['relatedHost'].text
			end
			if xml_element.elements['version'] != nil
				self.version = xml_element.elements['version'].text
			end
			if xml_element.elements['sourceLocation'] != nil
				self.source_location = xml_element.elements['sourceLocation'].text
			end
			if xml_element.elements['remarks'] != nil
				self.remarks = xml_element.elements['remarks'].text
			end
			if xml_element.elements['status'] != nil
				self.status = xml_element.elements['status'].text
			end
		end

	end

	class KalturaConfMapsListResponse < KalturaListResponse
		attr_accessor :objects


		def from_xml(xml_element)
			super
			if xml_element.elements['objects'] != nil
				self.objects = KalturaClientBase.object_from_xml(xml_element.elements['objects'], 'KalturaConfMaps')
			end
		end

	end

	class KalturaConfMapsBaseFilter < KalturaRelatedFilter
		attr_accessor :name_equal
		attr_accessor :related_host_equal
		attr_accessor :version_equal

		def version_equal=(val)
			@version_equal = val.to_i
		end

		def from_xml(xml_element)
			super
			if xml_element.elements['nameEqual'] != nil
				self.name_equal = xml_element.elements['nameEqual'].text
			end
			if xml_element.elements['relatedHostEqual'] != nil
				self.related_host_equal = xml_element.elements['relatedHostEqual'].text
			end
			if xml_element.elements['versionEqual'] != nil
				self.version_equal = xml_element.elements['versionEqual'].text
			end
		end

	end

	class KalturaConfMapsFilter < KalturaConfMapsBaseFilter


		def from_xml(xml_element)
			super
		end

	end


	class KalturaConfMapsService < KalturaServiceBase
		def initialize(client)
			super(client)
		end

		# Add configuration map
		# @return [KalturaConfMaps]
		def add(map)
			kparams = {}
			client.add_param(kparams, 'map', map)
			client.queue_service_action_call('confmaps_confmaps', 'add', 'KalturaConfMaps', kparams)
			if (client.is_multirequest)
				return nil
			end
			return client.do_queue()
		end

		# Get configuration map
		# @return [KalturaConfMaps]
		def get(filter)
			kparams = {}
			client.add_param(kparams, 'filter', filter)
			client.queue_service_action_call('confmaps_confmaps', 'get', 'KalturaConfMaps', kparams)
			if (client.is_multirequest)
				return nil
			end
			return client.do_queue()
		end

		# List configuration maps names
		# @return [array]
		def get_map_names()
			kparams = {}
			client.queue_service_action_call('confmaps_confmaps', 'getMapNames', 'KalturaString', kparams)
			if (client.is_multirequest)
				return nil
			end
			return client.do_queue()
		end

		# List configuration maps
		# @return [KalturaConfMapsListResponse]
		def list(filter)
			kparams = {}
			client.add_param(kparams, 'filter', filter)
			client.queue_service_action_call('confmaps_confmaps', 'list', 'KalturaConfMapsListResponse', kparams)
			if (client.is_multirequest)
				return nil
			end
			return client.do_queue()
		end

		# Update configuration map
		# @return [KalturaConfMaps]
		def update(map)
			kparams = {}
			client.add_param(kparams, 'map', map)
			client.queue_service_action_call('confmaps_confmaps', 'update', 'KalturaConfMaps', kparams)
			if (client.is_multirequest)
				return nil
			end
			return client.do_queue()
		end
	end

	class KalturaClient < KalturaClientBase
		attr_reader :conf_maps_service
		def conf_maps_service
			if (@conf_maps_service == nil)
				@conf_maps_service = KalturaConfMapsService.new(self)
			end
			return @conf_maps_service
		end
		
	end

end
