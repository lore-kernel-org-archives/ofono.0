Content-Type: multipart/mixed; boundary="===============4279221915455206461=="
MIME-Version: 1.0
From: Rajesh.Nagaiah@elektrobit.com
Subject: RE: CDMA SMS Handling
Date: Thu, 14 Oct 2010 11:26:46 -0700
Message-ID: <C681C76E0D5F1E4BB01DE79E0A80EEC702B1FFC5@usrdes03.ebgroup.elektrobit.com>
In-Reply-To: <4CB622DF.9030601@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4279221915455206461==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

>So personally I'd just extend the current enum sms_type with CDMA
variants, e.g.:
>	SMS_TYPE_CDMA_DELIVER, SMS_TYPE_CDMA_SUBMIT, etc and add the
cdma structures directly to the current union, e.g:
>
>struct sms {
>	struct sms_address sc_addr;
>	enum sms_type type;
>	union {
>		struct sms_deliver deliver;
>		struct sms_deliver_ack_report deliver_ack_report;
>		struct sms_deliver_err_report deliver_err_report;
>		struct sms_submit submit;
>		struct sms_submit_ack_report submit_ack_report;
>		struct sms_submit_err_report submit_err_report;
>		struct sms_command command;
>		struct sms_status_report status_report;
>
>		/* CDMA */
>		struct sms_cdma_deliver deliver;
>		struct sms_cdma_submit submit;
>		...
>	};
>};

We can do that way as well, but the only reason I proposed the other way
was not to mix the CDMA specific values to exisiting GSM data. For eg,
now we have add CDMA specific SMS types to the enum sms_type.

>Does CDMA have an SMSC address?

CDMA doesnt have Message center address


>Doing it the way I suggested would keep the impact on the current code
base absolutely minimal. This way you can start =

>submitting patches right away for CDMA support
>without impacting anyone.  Once the CDMA aspects are stabilized and
we're happy with them we can do the final struct / =

>API refactoring as needed.
>
>Thoughts?

Yes, i agree doing this way would have minimal impact to the current
code base. But from refactoring prespective the effort will be double if
we do the refactoring at the later stage, as now we need to refactor
only the GSM code and later we have to refactor both GSM and CDMA code.


BR,
Rajesh

--===============4279221915455206461==--

