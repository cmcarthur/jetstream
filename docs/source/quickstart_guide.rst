Quickstart Guide
================

Prerequisites
-------------

Before you can run Jetstream, you will need:

Docker
^^^^^^

Install Docker for your platform by following the `Docker instructions <https://docs.docker.com/engine/installation/>`_.

AWS Credentials
^^^^^^^^^^^^^^^

There are two ways to get AWS credentials installed -- you can use the **AWS CLI**, or just manually write an **AWS credentials file**.

**AWS CLI**

First, install the CLI with:

.. code-block:: bash

   pip install awscli

Then, configure your credentials with:

.. code-block:: bash

   aws configure --profile jetstream

Follow the prompts and copy in your AWS access key and secret.

**AWS Credentials File**

If you'd rather not install the AWS CLI, create a file at ``~/.aws/credentials`` with the following contents (replacing ``<your access key>`` and ``<your secret>`` with the values from your AWS account):

.. code-block:: bash

   [jetstream]
   aws_access_key_id = <your access key>
   aws_secret_access_key = <your secret>

Credentials File
----------------

Next, set up your variables file:

.. code-block:: bash

   cp state/variables.tfvars.example state/variables.tfvars

Update this file with your desired credentials. Using the default values is not recommended.

Plan / Apply
------------

Finally, use ``make plan`` / ``make apply`` to plan and apply changes to your account.
