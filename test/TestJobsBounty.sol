import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/GigRecruitmentNaive.sol";

/// @title   A solidity test contract for testing out the JobsBounty contract. This contract is within the GigRecruitmentNaive.sol file
/// @author  Rick Behl

contract TestJobsBounty {

    // Handle for the deployed JobsBountry contract created by each test
    JobsBounty deployedJobsBounty;

    // Generic test events - useful for debugging
    event testEventUint(uint val);
    event testEventUint256(uint256 val);
    event testEventString(string val);
    event testEventAddress(address val);

  /***
   * @notice function which sets up the handle to the JobsBounty contract before each test
   */
    function beforeEach() public {
        deployedJobsBounty = JobsBounty(DeployedAddresses.JobsBounty());
    }

  /***
   * @notice function which checks the end date on the jobs bounty
   */
    function testCheckEndDate() public {
        uint expectedEndDate = 1420070400;      // as per deployed contract
        Assert.equal(deployedJobsBounty.endDate(), expectedEndDate, "The end date should be correct");
    }    

  /***
   * @notice function which checks the job post on the jobs bounty
   */
    function testCheckCompanyPost() public {
        string memory expectedJobPost = "https://indorse.io/jobs/test_post";        // as per the deployed contract
        Assert.equal(deployedJobsBounty.jobPost(), expectedJobPost, "The job post should be correct");
    }    

  /***
   * @notice function which checks the company name on the jobs bounty
   */
    function testCheckCompanyName() public {
        string memory expectedCompanyName = "Indorse";      // as per the deployed contract
        Assert.equal(deployedJobsBounty.companyName(), expectedCompanyName, "The company name should be correct");
    }    

  /***
   * @notice function which checks the current balance in the contract
   */
    function testCheckOwnBalance() public {
        uint256 contractBalance = deployedJobsBounty.ownBalance();
        uint256 expectedBalance = 1000;
        Assert.equal(contractBalance, expectedBalance, "The balance should be correct");
    }    

  /***
   * @notice function which checks the current IND token address has been set
   */
    function testCheckINDTokenAddress() public {
        address INDTokenAddress = deployedJobsBounty.INDToken();
        Assert.notEqual(INDTokenAddress, 0, "The IND Token address should not be zero");
    }    

//   /***
//    * @notice function which checks the payOutBounty function works as expected
//    *         
//    */
//     function testPayOutBounty() public {
//         // Use Ganache accounts 3 & 4 for referrer and candidate respectively
//         address addrReferrer = 0x92762bE6dd2E8E0884c9DfA1F64EAB47B7d15f4F;
//         address addrCandidate = 0xBac3e800C5f2517634233e0415f92C2073e7c8d4;
//         // address ERC20INDToken = ERC20(deployedJobsBounty.INDToken());

//         emit testEventAddress(addrReferrer);
//         emit testEventAddress(addrCandidate);

//         // store balances before payout
//         uint balBeforeReferrer = ERC20(deployedJobsBounty.INDToken()).balanceOf(addrReferrer);
//         uint balBeforeCandidate = ERC20(deployedJobsBounty.INDToken()).balanceOf(addrCandidate);

//         emit testEventUint(balBeforeReferrer);
//         emit testEventUint(balBeforeCandidate);

//         // send the payout
//         deployedJobsBounty.payOutBounty(addrReferrer, addrCandidate);

//         // store balances after payout
//         uint balAfterReferrer = ERC20(deployedJobsBounty.INDToken()).balanceOf(addrReferrer);
//         uint balAfterCandidate = ERC20(deployedJobsBounty.INDToken()).balanceOf(addrCandidate);

//         // check payout amounts are what is expected
//         Assert.equal(balAfterReferrer - balBeforeReferrer, 0, "The payout should be half the bounty to the referrer");
//         Assert.equal(balAfterCandidate - balBeforeCandidate, 0, "The payout should be half the bounty to the candidate");
//     }    

}