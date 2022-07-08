# Before an Audit

## Choose a [Free Software](https://www.gnu.org/philosophy/free-sw.en.html) License

"Closed code is inherently insecure. If people who use your project can’t inspect it, study it, hack it, and experiment on it, there’s no way it can be trusted" [1]. I don't know if I totally agree, but I do think open software can be more robost because there are more eyes on it.

## Build your core team of maintainers

Proper maintenance is essential and putting together a team that can take care of the required work will be important for your software's long term success. It helps to have a leader to orchestrate things and to make sure you pass the bus test.

## Write Clean Code

KISS. Let the core maintainers reach consensus on the code style and run a linter on all new code that's added. Take your time and enjoy the process.

## Test.

Unit tests, integration test between all of your components, test from a users perspective, and test end-to-end system interactions. Find a way to enjoy testing and developing good processes (while difficult) will help keep bugs out of your system.

Utilize your community, your users will help validate your system.

## Write documentation

Your README should be a, "straightforward index of your project" [1]. It should also have a section describing how to disclose bugs and vulnerabilities.

Docstrings should follow [NatSpec Format](https://docs.soliditylang.org/en/develop/natspec-format.html). All public interfaces (ABI).

Lastly, user documentation. 

## Check your dependencies

Now that you have your house in order, you want to ensure your dependencies are secure. Are your dependencies going to be actively maintained?

## Build your community

Code without a community is insecure and "no amount of money, experience, or knowledge can substitute for [community]" [1]. Proper communication channels, marketing investments, and a community manager will help. But first, the project you're building needs to be interesting.

Community building skills [2]:

- understanding of how to spark engagement and interactions
- empathy
- good non violent communicator to handle conflict
- good leader

Scalable leadership programs in the community to create repeatable processes and educate.

## Sources

1. [Follow this quality checklist before an audit](https://blog.openzeppelin.com/follow-this-quality-checklist-before-an-audit-8cc6a0e44845/)
2. [David Spinks on Building Communities](https://open.spotify.com/episode/6u6aROuAwg5N2dUADqDm7R?si=70e8895a25bc48ff)
