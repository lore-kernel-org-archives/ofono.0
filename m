Content-Type: multipart/mixed; boundary="===============0182584737497020271=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: Re: [PATCH 1/2] GAtPPP: Add ACFC option support
Date: Fri, 24 Jun 2011 17:20:10 +0200
Message-ID: <4E04AB2A.3040002@linux.intel.com>
In-Reply-To: <4E04A23D.7000002@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0182584737497020271==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 24/06/2011 16:42, Denis Kenzior wrote:
> Hi Guillaume,
>
>>> Again, this seems wrong.  What is happening here is that the peer just
>>> told us that 'Yes, I can accept ACFC packets'.
>>>
>>> What you're trying to do is set whether our end can accept ACFC packets
>>> based on whether the peer can.  In fact, they are completely
>>> independent.  The relationship can be asymmetric, e.g. client that can
>>> send ACFC packets, but not accept them, and vice versa.  You need to
>>> account for this.
>>>
>> Right, so if we always set by default ACFC options into LCP configure
>> request.
>> I could dot into
>>
>> static void lcp_reset_config_options(struct lcp_data *lcp)
>> {
>>      /* Using the default ACCM */
>>      lcp->req_options |=3D REQ_OPTION_ACFC;
>>      lcp_generate_config_options(lcp);
>> }
>>
>>
>> On reception, we always say we can receive ACFC packet then it is up to
>> the peer to transmit or not ACFC packets.
>>
>> GAtPPP object only needs to know if it has to transmit or not ACFC packe=
ts.
>> That is the purpose of ppp->acfc.
> I'd like to have the option of turning off ACFC completely, so it should
> control:
> 1. Whether we advertise that we can receive ACFC packets
> 2. Whether we should try to send ACFC packets
>

Fine I will add it.
I guess we will need same kind of options for PFC.

Kind regards,
Guillaume

--===============0182584737497020271==--

