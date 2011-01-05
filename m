Content-Type: multipart/mixed; boundary="===============5665476464298207465=="
MIME-Version: 1.0
From: Rajesh.Nagaiah@elektrobit.com
Subject: RE: [PATCH v3 2/7] cdma-sms: Add CDMA SMS Support
Date: Wed, 05 Jan 2011 11:17:12 -0800
Message-ID: <C681C76E0D5F1E4BB01DE79E0A80EEC702E6576B@usrdes03.ebgroup.elektrobit.com>
In-Reply-To: <1294182050-5526-1-git-send-email-lei.2.yu@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5665476464298207465==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lei,
 =

> +void ofono_cdma_sms_deliver_notify(struct ofono_cdma_sms *cdma_sms,
> +					unsigned char *pdu, int
tpdu_len);

As there is no SC number in CDMA, the whole PDU is the actual TPDU as
well.
So either we should call pdu/pdu_len or tpdu/tpdu_len. Having
pdu/tpdu_len
might be mistaken.

BR,
Rajesh

--===============5665476464298207465==--

