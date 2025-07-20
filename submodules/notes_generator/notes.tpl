# Topic: ${topic} - Sub_Topic: ${sub_topic}

## documentation:
%{ for name, obj in links ~}
%{ if obj.type == "documentation" }
* [${name}](${obj.link})
%{ endif ~}
%{ endfor ~}

## tutorials:
%{ for name, obj in links ~}
%{ if obj.type == "tutorials" }
* [${name}](${obj.link})
%{ endif ~}
%{ endfor ~}
