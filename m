Content-Type: multipart/mixed; boundary="===============8723934933528664979=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 0/5] Call Counters
Date: Mon, 15 Nov 2010 17:13:10 +0100
Message-ID: <1289837590.3266.125.camel@aeonflux>
In-Reply-To: <cover.1289819191.git.Andras.Domokos@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8723934933528664979==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andras,

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

and where is the API documentation for such a D-Bus interface?

Regards

Marcel



--===============8723934933528664979==--

