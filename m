Content-Type: multipart/mixed; boundary="===============0474358012258806018=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: CDMA SMS Handling
Date: Wed, 13 Oct 2010 16:21:35 -0500
Message-ID: <4CB622DF.9030601@gmail.com>
In-Reply-To: <C681C76E0D5F1E4BB01DE79E0A80EEC702ACA2F9@usrdes03.ebgroup.elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0474358012258806018==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Rajesh,

> I did an analysis of the existing smsutils fuctionalities for the code
> reusability. If we can make the struct sms common for both GSM and CDMA
> by having them as union members, then we can re-use sms assembly
> serialization and fragmentation/de-fragmentation logic with only minor
> changes and no interface changes. Also this struct change will later
> help in multimode case as well, if we have plans for a multimode stack.
> =

> Existing struct sms:
> =

> struct sms {
> 	struct sms_address sc_addr;
> 	enum sms_type type;
> 	union {
> 		struct sms_deliver deliver;
> 		struct sms_deliver_ack_report deliver_ack_report;
> 		struct sms_deliver_err_report deliver_err_report;
> 		struct sms_submit submit;
> 		struct sms_submit_ack_report submit_ack_report;
> 		struct sms_submit_err_report submit_err_report;
> 		struct sms_command command;
> 		struct sms_status_report status_report;
> 	};
> };
> =

> Proposed struct sms:
> =

> struct sms {
> 	enum sms_type type;
> 	union {
> 		struct gsm_sms g_sms;
> 		struct cdma_sms c_sms;
> 	};
> };

So personally I'd just extend the current enum sms_type with CDMA
variants, e.g.:
	SMS_TYPE_CDMA_DELIVER, SMS_TYPE_CDMA_SUBMIT, etc and add the cdma
structures directly to the current union, e.g:

struct sms {
	struct sms_address sc_addr;
	enum sms_type type;
	union {
		struct sms_deliver deliver;
		struct sms_deliver_ack_report deliver_ack_report;
		struct sms_deliver_err_report deliver_err_report;
		struct sms_submit submit;
		struct sms_submit_ack_report submit_ack_report;
		struct sms_submit_err_report submit_err_report;
		struct sms_command command;
		struct sms_status_report status_report;

		/* CDMA */
		struct sms_cdma_deliver deliver;
		struct sms_cdma_submit submit;
		...
	};
};

<snip>

> struct cdma_sms {
> 	enum cdma_sms_type type;

Does CDMA have an SMSC address?

> 	union {
> 		struct cdma_sms_deliver deliver;
> 		struct cdma_sms_submit submit;
> 		struct cdma_sms_cancel cancel;
> 		struct cdma_sms_delivery_ack delivery_ack;
> 		struct cdma_sms_user_ack user_ack;
> 		struct cdma_sms_read_ack read_ack;
> 		struct cdma_sms_deliver_report deliver_report;
> 		struct cdma_sms_submit_report submit_report;
> 	};
> };
> =

> Let me know your feedback on this. If we agree on this, then one of the
> first tasks should be to do this struct change on the exising code, so
> that GSM developement can happen parallely based on this new structural
> change.

Doing it the way I suggested would keep the impact on the current code
base absolutely minimal.  This way you can start submitting patches
right away for CDMA support without impacting anyone.  Once the CDMA
aspects are stabilized and we're happy with them we can do the final
struct / API refactoring as needed.

Thoughts?

Regards,
-Denis

--===============0474358012258806018==--

