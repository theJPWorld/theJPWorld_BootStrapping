locals {
  rgName_umi_complete         = "${var.rgName_umi}-${var.app_short}-${var.environment}-${var.locationShort}-01"
  rgName_state_complete       = "${var.rgName_state}-${var.app_short}-${var.environment}-${var.locationShort}-01"
  buildServiceConnectionName  = "${var.serviceConnectionName_Build}-${var.app_short}-${var.environment}-${var.locationShort}-01"
  deployServiceConnectionName = "${var.serviceConnectionName_Deploy}-${var.app_short}-${var.environment}-${var.locationShort}-01"
}
