Content-Type: multipart/mixed; boundary="===============5518510736191244295=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: [PATCH 0/5] Call Counters (2nd)
Date: Tue, 07 Dec 2010 14:57:53 +0200
Message-ID: <AANLkTim07pnimBQFXt8z43ewjPOW9GSobv8yTLJyfGmR@mail.gmail.com>
In-Reply-To: <cover.1290442823.git.Andras.Domokos@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5518510736191244295==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andras,

2010/11/22 Andras Domokos <Andras.Domokos@nokia.com>:
> Here a proposal for call counters implementation for keeping track
> of the total incoming and outgoing call duration counters. Each
> established call instance is contributing to either of the call
> duration counters. The 2 counters are updated periodically when
> there is an established call and the information is stored in
> a file. The bookkeeping of the call duration counters are per IMSI
> number.
> The implementation makes use of the history framework which had to be
> expanded with a function for marking the beginning of a voice call.
> There is a D-Bus interface to call counters for reading and clearing
> the counters.

This set looks good to me, and I believe you fixed the issues from
previous review comments. Denis, are you ok with this?

Cheers,
Aki

--===============5518510736191244295==--

