Content-Type: multipart/mixed; boundary="===============4236880839657051897=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] GAtPPP: Add ACFC option support
Date: Fri, 24 Jun 2011 09:42:05 -0500
Message-ID: <4E04A23D.7000002@gmail.com>
In-Reply-To: <4E044DBB.4080707@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4236880839657051897==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume,

>> Again, this seems wrong.  What is happening here is that the peer just
>> told us that 'Yes, I can accept ACFC packets'.
>>
>> What you're trying to do is set whether our end can accept ACFC packets
>> based on whether the peer can.  In fact, they are completely
>> independent.  The relationship can be asymmetric, e.g. client that can
>> send ACFC packets, but not accept them, and vice versa.  You need to
>> account for this.
>>
> =

> Right, so if we always set by default ACFC options into LCP configure
> request.
> I could dot into
> =

> static void lcp_reset_config_options(struct lcp_data *lcp)
> {
>     /* Using the default ACCM */
>     lcp->req_options |=3D REQ_OPTION_ACFC;
>     lcp_generate_config_options(lcp);
> }
> =

> =

> On reception, we always say we can receive ACFC packet then it is up to
> the peer to transmit or not ACFC packets.
> =

> GAtPPP object only needs to know if it has to transmit or not ACFC packet=
s.
> That is the purpose of ppp->acfc.

I'd like to have the option of turning off ACFC completely, so it should
control:
1. Whether we advertise that we can receive ACFC packets
2. Whether we should try to send ACFC packets

Regards,
-Denis

--===============4236880839657051897==--

