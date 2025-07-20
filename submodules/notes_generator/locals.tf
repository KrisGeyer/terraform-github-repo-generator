locals {
  files = flatten(
    [for key_topic, topic in var.file_map : [
      for key_sub_topic, sub_topic in topic : [
        {
          topic     = replace(key_topic, " ", "_")
          sub_topic = replace(key_sub_topic, " ", "_")
          links     = sub_topic.links
        }
      ]
      ]
    ]
  )
}