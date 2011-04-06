Content-Type: multipart/mixed; boundary="===============1103598180136245430=="
MIME-Version: 1.0
From: Arun Ravindran <ext-arun.1.ravindran@nokia.com>
Subject: Re: [RFC PATCH v3] gprs: add function to handle activated context
Date: Wed, 06 Apr 2011 17:06:20 +0300
Message-ID: <4D9C735C.50902@nokia.com>
In-Reply-To: <BANLkTikCNtgvi2kNWDQOTabkKmtcM7QUEQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1103598180136245430==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pessi,

> Hi Arun,
>
> 2011/4/6 Arun Ravindran<ext-arun.1.ravindran@nokia.com>:
>> According to this, the cid of user initiated context and network initiat=
ed
>> context doesn't overlap.
> The problem is, the initial EPS context is initiated by mobile, not by
> the network. The mobile sends a piggybacked
> PDN CONNECTIVITY REQUEST with the initial attach request in order to
> initiate the initial EPS context.
>

How does this happen from oFono (or in the TE-MT Interface).

Does it mean that in for EPS context the TE will have to do the same =

steps what it does for GPRS?

The PDN CONNECTIVITY REQUEST has the APN name, and for TE, CGDCONT to =

set the APN is called with a context id, in that case what is the need =

for the cid handling done in this patch?

Regards
Arun


--===============1103598180136245430==--

