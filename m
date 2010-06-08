Content-Type: multipart/mixed; boundary="===============3880559401800030868=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: Re: [RFC v2] Readout technology form Option HSO modems
Date: Tue, 08 Jun 2010 13:11:42 +0200
Message-ID: <4C0E256E.2010007@monom.org>
In-Reply-To: <20100608082849.GA7584@pc0043.bmw-carit.intra>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3880559401800030868==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 06/08/2010 10:28 AM, Daniel Wagner wrote:
> To find out which the current technology is on
> we have to issue OCTI and OWCTI. OCTI returns
> 2G information and OWCTI returns 3G information.
> OWCTI overrules OCTI.

I had a short look at my Huawei E160 modem. On the secondary
channel it reports with MODE unsolicited message
the current technology. So this could be handled in the
same way as the Option approach. If my proposed patch is
okay, I can write one for Huawei too.

cheers,
daniel

--===============3880559401800030868==--

