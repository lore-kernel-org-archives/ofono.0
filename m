Content-Type: multipart/mixed; boundary="===============0849549107469275085=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/6] lte-api: protocol and authentication properties
Date: Thu, 11 Oct 2018 23:06:06 -0500
Message-ID: <1df9304c-e4c4-8465-1f1b-0e47c95c08c1@gmail.com>
In-Reply-To: <CAKSBH7HVsDzO7RSc9O_KVH-LSMWqUMa4Ag1=W6fjUdHRxa-Bqg@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0849549107469275085==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Giacinto,

>> Reading through your patches, I'm missing an overarching explanation of
>> why we need this.  Do you really have an LTE network in range that
>> requires authentication for the default APN?
> =

> yes, quite a few of them actually.
> And all private APN I have seen so far require authentication, even
> for the combined attach.
> =


Are these networks something a typical user would see?  Or is this =

mainly for M2M type usecases?

Fundamentally this whole username / password for a default bearer =

activation is utterly insane.  The network provider has your IMSI, it =

can lookup whether you're authorized for that APN or not, or suggest you =

an APN that will work...  But I digress..

> =

> Shall I extend the explanation?

An extended explanation is always a good idea.  Especially for something =

that seems to be pretty esoteric.

> There wasn't much of an explanation why we need a default APN for LTE, ei=
ther.
> =


Sure there was.  Not sure why you say that :)  Maybe it wasn't recorded =

in the git commit but it was discussed on the mailing list, IRC, etc. =

But again, see above.  The whole default attach APN needing to be =

provisioned by the client is utterly insane.

Regards,
-Denis

--===============0849549107469275085==--

