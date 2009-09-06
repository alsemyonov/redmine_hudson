# $Id$
# To change this template, choose Tools | Templates
# and open the template in the editor.

require "uri"
require 'net/http'

module HudsonHelper

  def parse_rss_build(entry)
    params = get_element_value(entry, "title").scan(/(.*)#(.*)\s\((.*)\)/)[0]
    retval = {}
    retval[:name] = params[0].strip
    retval[:number] = params[1]
    retval[:result] = params[2]
    retval[:url] = "#{entry.elements['link'].attributes['href']}"
    retval[:published] = Time.xmlschema(get_element_value(entry, "published")).localtime
    retval[:building] = false
    return retval
  end

  def parse_changeset(element)
    retval = {}
    retval[:kind] = get_element_value(element, "kind")
    retval[:revisions] = []
    element.children.each {|child|
      if "revision" == child.name
        revision = {}
        revision[:module] = get_element_value(child, "module")
        revision[:revision] = get_element_value(child, "revision")
        retval[:revisions] << revision
      end
    }
    return retval
  end

  def check_box_to_boolean(item)
    return item if item
    return false unless item
  end

end
