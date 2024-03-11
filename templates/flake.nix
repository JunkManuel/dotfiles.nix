{
    description = "My nix Templates";

    inputs = {
        of-templates.url = github:NixOs/templates;
    };

    outputs = { self, of-templates, ... }: {
        templates = {
            python-devel = {
                path = ./python/python-devel;
                description = "A basic python package development environment";
            };
            pscript = {
                path = ./python/python-scripts;
                description = "Prepared python scripting environment";
            };
        } // of-templates.templates;
    };
}
