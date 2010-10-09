Content-Type: multipart/mixed; boundary="===============4596628581005447637=="
MIME-Version: 1.0
From: Rajesh.Nagaiah@elektrobit.com
Subject: RE: CDMA SMS Handling
Date: Fri, 08 Oct 2010 18:19:43 -0700
Message-ID: <C681C76E0D5F1E4BB01DE79E0A80EEC702ACA2F9@usrdes03.ebgroup.elektrobit.com>
In-Reply-To: <4CAD0FDC.7030103@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4596628581005447637==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis/Marcel,

>This gets my vote, I like to start bottom up.  E.g. build the
infrastructure first, with unit tests, etc and then hook
>up the controlling logic.  So starting cdma smsutils =

>seems like a good idea to me.

I agree, starting with the cdma smsutils should be the starting point,
along with the unit test developement.

>Do note however that there's more to smsutils than basic parsing.  We
also have sms fragmentation / de-fragmentation
>logic, sms assembly serialization, status reports, =

>character encoding / decoding, etc.  We will have to figure out which
parts can be re-used for both CDMA and GSM as we =

>go along...

I did an analysis of the existing smsutils fuctionalities for the code
reusability. If we can make the struct sms common for both GSM and CDMA
by having them as union members, then we can re-use sms assembly
serialization and fragmentation/de-fragmentation logic with only minor
changes and no interface changes. Also this struct change will later
help in multimode case as well, if we have plans for a multimode stack.

Existing struct sms:

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
	};
};

Proposed struct sms:

struct sms {
	enum sms_type type;
	union {
		struct gsm_sms g_sms;
		struct cdma_sms c_sms;
	};
};

struct gsm_sms {
	struct sms_address sc_addr;
	enum gsm_sms_type type;
	union {
		struct sms_deliver deliver;
		struct sms_deliver_ack_report deliver_ack_report;
		struct sms_deliver_err_report deliver_err_report;
		struct sms_submit submit;
		struct sms_submit_ack_report submit_ack_report;
		struct sms_submit_err_report submit_err_report;
		struct sms_command command;
		struct sms_status_report status_report;
	};
};

struct cdma_sms {
	enum cdma_sms_type type;
	union {
		struct cdma_sms_deliver deliver;
		struct cdma_sms_submit submit;
		struct cdma_sms_cancel cancel;
		struct cdma_sms_delivery_ack delivery_ack;
		struct cdma_sms_user_ack user_ack;
		struct cdma_sms_read_ack read_ack;
		struct cdma_sms_deliver_report deliver_report;
		struct cdma_sms_submit_report submit_report;
	};
};

Let me know your feedback on this. If we agree on this, then one of the
first tasks should be to do this struct change on the exising code, so
that GSM developement can happen parallely based on this new structural
change.

BR,
Rajesh

--===============4596628581005447637==--

