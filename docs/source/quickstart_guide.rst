Quickstart Guide
================

To get started, you will need:

 - `Docker <https://docs.docker.com/engine/installation/>`
 - `AWS CLI <pip install awscli>`

Once you have the above installed, you need to configure AWS locally:

.. code-block: bash

   aws configure --profile jetstream

Follow the prompts and copy in your AWS access key and secret.

Next, set up your variables file:

.. code-block: bash

   cp state/variables.tfvars.example state/variables.tfvars

Update this file with your desired credentials. Using the default values is not recommended.
