locals {
  rgName_umi_complete         = "${var.rgName_umi}-${var.app_short}-${var.environment}-${var.locationShort}-01"
  rgName_state_complete       = "${var.rgName_state}-${var.app_short}-${var.environment}-${var.locationShort}-01"
  umiName_build_complete = "${var.umiName_tf}build-${var.app_short}-${var.environment}-${var.locationShort}"
  umiName_deploy_complete = "${var.umiName_tf}deploy-${var.app_short}-${var.environment}-${var.locationShort}"
  buildServiceConnectionName  = "${var.serviceConnectionName_Build}-${var.app_short}-${var.environment}-${var.locationShort}-01"
  deployServiceConnectionName = "${var.serviceConnectionName_Deploy}-${var.app_short}-${var.environment}-${var.locationShort}-01"
}