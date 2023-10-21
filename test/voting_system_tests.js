const VotingContract = artifacts.require("VotingContract");

contract("VotingContract", (accounts) => {
  let instance;

  before(async () => {
    instance = await VotingContract.deployed();
  });

  it("should have three candidates", async () => {
    const count = await instance.candidatesCount();
    assert.equal(count, 3);
  });

  it("should let a voter vote", async () => {
    await instance.vote(1, "John Doe", "12345678", { from: accounts[0] });
    const voteCount = (await instance.getCandidate(1))[2];
    assert.equal(voteCount, 1, "Vote count should be 1 after voting");
  });

  it("shouldn't let a voter vote twice", async () => {
    try {
      await instance.vote(1, "John Doe", "12345678", { from: accounts[0] });
      assert.fail("Expected revert not received");
    } catch (error) {
      const revert = error.message.search("revert") >= 0;
      assert(revert, "Expected revert, got another error: " + error.message);
    }
  });

  it("shouldn't allow non-existent candidate votes", async () => {
    try {
      await instance.vote(4, "John Doe", "12345678", { from: accounts[1] });
      assert.fail("Expected revert not received");
    } catch (error) {
      const revert = error.message.search("revert") >= 0;
      assert(revert, "Expected revert, got another error: " + error.message);
    }
  });

  it("should update total voters count", async () => {
    await instance.vote(1, "Jane Smith", "87654321", { from: accounts[2] });
    const total = await instance.getTotalVoters();
    assert.equal(total.toNumber(), 2, "Total voters should be 2");
  });

  it("should check if a voter has already voted", async () => {
    const hasVoted = await instance.hasAlreadyVoted("12345678");
    assert.equal(hasVoted, true, "This voter should have already voted");
  });
});
