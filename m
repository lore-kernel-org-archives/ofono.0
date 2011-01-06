Content-Type: multipart/mixed; boundary="===============6025662445286021400=="
MIME-Version: 1.0
From: Lei Yu <lei.2.yu@nokia.com>
Subject: Re: [PATCH v3 2/7] cdma-sms: Add CDMA SMS Support
Date: Thu, 06 Jan 2011 08:58:37 -0800
Message-ID: <4D25F4BD.9010200@nokia.com>
In-Reply-To: <C681C76E0D5F1E4BB01DE79E0A80EEC702E6576B@usrdes03.ebgroup.elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6025662445286021400==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Rajesh,

On 01/05/2011 11:17 AM, ext Rajesh.Nagaiah(a)elektrobit.com wrote:
> Hi Lei,
>
>> +void ofono_cdma_sms_deliver_notify(struct ofono_cdma_sms *cdma_sms,
>> +					unsigned char *pdu, int
> tpdu_len);
>
> As there is no SC number in CDMA, the whole PDU is the actual TPDU as
> well.
> So either we should call pdu/pdu_len or tpdu/tpdu_len. Having
> pdu/tpdu_len
> might be mistaken.
>

Will change to tpdu/tpdu_len per CDMA SMS spec for transport layer.

> BR,
> Rajesh
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono

Regards,
Lei


--===============6025662445286021400==--

