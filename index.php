<?php

$conn = mysqli_connect("localhost","root","","marshell");
// Check connection
if (mysqli_connect_errno()) {
  echo "Failed to connect to MySQL: " . mysqli_connect_error();
  exit();
}

function checkSignedDocuments($transaction_id,$conn){
	$hasSignedAllDocuments = 'No';
	
	$res_disclaimer = $res_w9_code = array();
	
	$qry_disclaimer = "select disclaimer_code from loan_transactions where transaction_id ='".$transaction_id."'";
	$qry_disclaimer1 =  mysqli_query($conn,$qry_disclaimer);
	$res_disclaimer = mysqli_fetch_assoc($qry_disclaimer1);

	if($res_disclaimer['disclaimer_code']=='0'){
		return $hasSignedAllDocuments;
	}else{
	     $qry_w9_code = "select lender_entities.w9_document_code
		from loan_transactions inner join lender_entities
		on loan_transactions.new_lender_id = lender_entities.lender_id
		where loan_transactions.transaction_id ='".$transaction_id."'";
		$qry_w9_code1 = mysqli_query($conn,$qry_w9_code);
		
		$hasSignedAllDocuments = 'Yes';
		if(mysqli_num_rows($qry_w9_code1)>0){
			while($res_w9_code = mysqli_fetch_assoc($qry_w9_code1)){
				if($res_w9_code['w9_document_code']=='0'){
					$hasSignedAllDocuments = 'No';
					break;
				}
			}
		}else{
			$hasSignedAllDocuments = 'Yes';
		}
	}
	
	return $hasSignedAllDocuments;
}

if(isset($_REQUEST['submit'])){
	
	$sort_order = "DESC";
	if($_REQUEST['order_transaction']=='loan_amount_asc'){
		$sort_order = "ASC";
	}
	
	$returnArr = array();
	//Sorting the Loan Transactions by Loan Amount from largest to smallest and as per the limit
	 $qry_sort_order =  "SELECT loan_transactions.transaction_id   ,loan_transactions.transaction_type,loan_details.loan_id,loan_details.loan_amount,loan_details.interest_rate,loan_details.loan_status
	FROM loan_transactions INNER JOIN loan_details
	ON loan_transactions.loan_id = loan_details.loan_id 
	ORDER BY loan_details.loan_amount ".$sort_order." LIMIT ".$_REQUEST['limit_transaction'];
	$qry_sort_order1 =  mysqli_query($conn,$qry_sort_order);
	if(mysqli_num_rows($qry_sort_order1)>0){
			echo "<h1>Showing List of transactions:</h1>";
			echo "<table border='2' style='border-collapse: collapse;'>
			<tr><th>Transaction ID</th><th>Transaction Type</th><th>Loan ID</th><th>Loan Amount</th><th>Interest Rate</th><th>Loan Status</th><th>Has Signed All Documents</th></tr>
			";
			
			
		while($res_sort_order = mysqli_fetch_assoc($qry_sort_order1)){
			
			$hasSignedAllDocuments = checkSignedDocuments($res_sort_order['transaction_id'],$conn);
			echo "<tr><td>".$res_sort_order['transaction_id']."</td><td>".$res_sort_order['transaction_type']."</td><td>".$res_sort_order['loan_id']."</td><td>".$res_sort_order['loan_amount']."</td><td>".$res_sort_order['interest_rate']."</td><td>".$res_sort_order['loan_status']."</td><td>".$hasSignedAllDocuments."</td></tr>";
			
			$returnArr[] = array(
			 'transaction_id'=> $res_sort_order['transaction_id'],
			 'transaction_type' => $res_sort_order['transaction_type'],
			 'loan_id' => $res_sort_order['loan_id'],
			 'loan_amount' => $res_sort_order['loan_amount'],
			 'interest_rate' => $res_sort_order['interest_rate'],
			 'loan_status'=> $res_sort_order['loan_status'],
			);
		}
		
		echo "</table>";
		
		echo "<h1>JSON FORMAT OUTPUT DATA</h1>";
		echo json_encode($returnArr);
		
		echo "<hr>";
	}
}

?>

<form method ='post'>
 <table >
<tr><td>Number of transaction ?: </td><td><input type ='text' value='5' name='limit_transaction' id='limit_transaction' required></td>
<tr><td>Order of transactions : </td><td><select name='order_transaction' id='order_transaction' required>
<option value='loan_amount_desc' selected> Order by Loan Amount Desc </option>
<option value='loan_amount_asc' > Order by Loan Amount Asc </option>
</select></td>
<tr><td colspan='2'>
<input type='submit' name='submit' value='Submit'></tr></td>
</table>
</form>
