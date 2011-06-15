Content-Type: multipart/mixed; boundary="===============4173926654846328098=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: Re: Problems ofono 0.45 and Nokia 6760
Date: Wed, 15 Jun 2011 13:57:10 +0300
Message-ID: <1308135430.2565.335.camel@tucson>
In-Reply-To: <4DEF85AF.8000900@zirak.it>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4173926654846328098==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Claudio,

On Wed, 2011-06-08 at 16:22 +0200, ext Claudio Degioanni wrote:
> Error org.ofono.Error.NotAttached: GPRS is not attached

Has this been working before?

It looks like the network registration status query fails with a
SERVICE_NOT_IDENTIFIED service type. My suspicion is that the phone
actually blocks this query, for reasons unknown. Either that, or the API
has changed since 10.001 in a backwards incompatible way unknown to me.

Because of this, the GPRS atom doesn't think the device is registered
and no attach happens.

There's not much that can be done if the query is indeed intentionally
blocked. I didn't find any documented change in the API, so it's not
possible to try to use a different type of query based on version here.

So my advice is to simply use DUN via USB ACM interface. So I think the
nokia driver might work better than the isiusb one in this case.

Cheers,
Aki


--===============4173926654846328098==--

