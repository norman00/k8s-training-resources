local frontend = import "frontend.json";

local cont = frontend.spec.template.spec.containers[0];

frontend {
  "spec"+: {
    "template"+: {
      "spec"+: {
        "containers": [
          cont {
              "env"+: [
                {
                  "name": "WORDPRESS_BLOG_NAME",
                  "value": "My blog"
                }
              ]
            }
        ]
      }
    }
  }
}
