const VotingContract = artifacts.require("./VotingContract.sol");

contract("VotingContract", function (accounts) {
  let votingContract;
  const owner = accounts[0];
  const voter1 = accounts[1];
  const voter2 = accounts[2];

  beforeEach(async function () {
    votingContract = await VotingContract.deployed();
  });

  it("initializes with two candidates", async function () {
    const count = await votingContract.candidatesCount();
    assert.equal(count, 2);
  });

  it("allows a voter to cast a vote", async function () {
    await votingContract.vote(1, "Alice", "12345678", { from: voter1 });
    const voter = await votingContract.voters(voter1);
    assert.equal(voter.name, "Alice");
    assert.equal(voter.voterId, "12345678");

    const candidate = await votingContract.getCandidate(1);
    assert.equal(candidate[2], 1, "Candidate's vote count did not increase.");
  });

  it("prevents a voter from voting more than once", async function () {
    await votingContract.vote(1, "Bob", "87654321", { from: voter2 });
    try {
      await votingContract.vote(1, "Bob", "87654321", { from: voter2 });
      assert.fail("Expected revert not received");
    } catch (error) {
      const revertReceived = error.message.search("revert") >= 0;
      assert(revertReceived, `Expected "revert", got ${error} instead`);
    }
  });

  it("retrieves the correct total number of voters", async function () {
    const total = await votingContract.getTotalVoters();
    assert.equal(total, 2);
  });

  it("retrieves a candidate correctly", async function () {
    const candidate = await votingContract.getCandidate(1);
    assert.equal(candidate[0], 1, "Candidate ID is correct.");
    assert.equal(candidate[1], "Candidate 1", "Candidate name is correct.");
  });
});
