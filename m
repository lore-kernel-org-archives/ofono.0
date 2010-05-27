Content-Type: multipart/mixed; boundary="===============4842385561833018338=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: Re: [PATCH 04/11] Changes for SMS statur report.
Date: Thu, 27 May 2010 14:41:23 +0300
Message-ID: <1274960483.3755.501.camel@tucson.research.nokia.com>
In-Reply-To: <1274957690-4893-4-git-send-email-pasi.miettinen@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4842385561833018338==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2010-05-27 at 12:54 +0200, ext pasi.miettinen(a)ixonos.com wrote:
> diff --git a/include/sms.h b/include/sms.h
> index daaec37..c007675 100644
> --- a/include/sms.h
> +++ b/include/sms.h
> @@ -54,7 +54,7 @@ struct ofono_sms_driver {
>  =

>  void ofono_sms_deliver_notify(struct ofono_sms *sms, unsigned char *pdu,
>  				int len, int tpdu_len);
> -void ofono_sms_status_notify(struct ofono_sms *sms, unsigned char *pdu,
> +void ofono_sms_status_report_notify(struct ofono_sms *sms, unsigned char=
 *pdu,
>  				int len, int tpdu_len);

Actually, I think we should have a single ofono_sms_pdu_notify(), and
let the core handle demuxing the different message types after parsing
the PDU.

ISI modems don't have different messages for deliver and status report;
the modem just sends a TPDU.

Cheers,
Aki



--===============4842385561833018338==--

