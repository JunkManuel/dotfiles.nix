{
    description = "My nix Templates";

    inputs = {
        of-templates.url = github:NixOs/templates;
    };

    outputs = { self, of-templates, ... }: {
        templates = {
            python-devel = {
                path = ./python;
                description = "A basic python package development environment";
            };
        } // of-templates.templates;
    };
}
