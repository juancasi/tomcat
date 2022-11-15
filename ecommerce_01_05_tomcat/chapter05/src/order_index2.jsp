		</div>
		<!-- /.row -->
	</div>
	<!-- /.container -->
	<br/><br/>
	<!-- Footer -->
	<jsp:include page="../portal/footer.jsp"></jsp:include>
	<!-- Bootstrap core JavaScript -->
	<script src="https://code.jquery.com/jquery-3.3.1.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
	<script src="../js/portal.js"></script>
	<script src="../js/purchase.js"></script>
	<script>
		$(document).ready(function() {
			getPurchases();
			getItems(0);
		});
	</script>
</body>
</html>