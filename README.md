# Test Engineer - Take Home Task


In your role as a test engineer / reliability engineer you will be building and
operating a blockchain test network infrastructure. In this take home task we
would like you to build a **tiny** version of the above.


#### Instructions

Write a small command line tool that:

- Takes as input a docker image tag (e.g. `parity/substrate:2.0.0-31c633c47`).

- Deploys the corresponding docker image as a container with the Substrate
  `--dev` command line flag.

- Wait until the block height exceeds ten blocks.

- Takes down the deployment.

- Reports the result of the test by returning either 0 for success or non-zero
  for failure on the command line.


##### Hint

- You can retrieve the current block number via the JSON API. For example with
  *curl* and *jq* you could retrieve the current block number with:

  ```shell
  curl \
          -H "Content-Type: application/json" \
          -d '{"id":1, "jsonrpc":"2.0", "method": "chain_getBlock"}' \
          localhost:9933 \
  | jq \
          .result.block.header.number
  ```

- The block number returned by the `chain_getBlock` endpoint is a [SCALE][1]
  encoded integer represented in hexadecimal format. For all block number values
  within the range `[0, 2^6)` one can ignore the fact that it is SCALE encoded
  (given that it would be within the *single byte mode*). You can either ignore
  the special encoding and stay within the before mentioned range, import a
  library to do the encoding, ... or write one yourself.


#### Additional information

##### Programming language

You can use whatever programming language you like to write the command line
tool. Make sure to include instructions on how to build and run the tool within
the final Git repository.


##### Deployment tooling

You can use whatever deployment automation tool (e.g. Kubernetes, Nomad, Docker
Swarm, Ansible, Terraform, ...) you like. The only requirement is that all code
and configuration needed to deploy the container needs to be included as code in
the final Git repository. It is not necessarily required that you include the
code and configuration to spin up the underlying infrastructure (e.g. virtual
machine) in the Git repository.

For example: Say you choose Kubernetes to deploy the docker image, you would
need to include manifests like *Namespace*, *Service* and *Deployment* files in
your final submission. It is not necessarily required to include code and
configuration needed to deploy the Kubernetes cluster itself.


##### Documentation

With this take home task we would like to understand how you tackle tasks like
the above. In order for us to easier understand what your reasoning for certain
decisions is, please make sure to write **good code comments** and
**documentation** and maintain a **proper Git history** with commit messages
explaining each step.

Feel free to include a list of ideas on how to improve your final project under
the assumption that you have unlimited time and resources to spend on it.


##### Expected timeline

The entire task should only take 2-3 hours, but you’re free to take it as far as
you like. We don't expect you to come up with a perfect solution, nor do we want
to exploit the idea of a take home task by requiring you to build the entire
blockchain test network infrastructure. Whenever you run out of time, add a
comment describing what you would have done if you had more time.


##### Submission details

Please fork this Git repository, add all your changes as Git commits on top and
send us a copy of the repository as a .zip file via e-mail.


In case you have any questions in regards to the task feel free to reach out to
us.

[1]: https://substrate.dev/docs/en/overview/low-level-data-format#compact-general-integers
