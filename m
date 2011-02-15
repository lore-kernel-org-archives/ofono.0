Content-Type: multipart/mixed; boundary="===============3265816277969593162=="
MIME-Version: 1.0
From: Pekka Pessi <ppessi@gmail.com>
Subject: Re: [RFCv3] doc: Proposal for LTE/IMS API
Date: Tue, 15 Feb 2011 16:02:44 +0200
Message-ID: <AANLkTikUHiVe2BBNxjOWc81Mx5T=9XAw8-9FSxwhs2r7@mail.gmail.com>
In-Reply-To: <1297377234-5056-1-git-send-email-sjurbren@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3265816277969593162==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sjur,

2011/2/11 Sjur Br=C3=A6ndeland <sjurbren@gmail.com>:
> With latest changes the P-CSCF addresses from ISIM can be read
> from the IpMultimediaIdentity objects and the P-CSCF addresses
> returned as dynamic parameters for the PDN Connection are avilable
> in the ConnectionContext object.
>
> I have also added LocalAddress to the IMS QoS SIP PreCondiction check.
> The Local IP address identifies the APN, so that PreCondition check
> in effect can be done per IMS APN.

This looks pretty good to me.

I take that an application that does
IpMultimediaSubsystem.Register("voice") implicitly support SR-VCC? Or
should you add a separate register-token for it, too?

Another issue is the list of ISIMs, the current oFono way of providing
list of objects is via separate Get* method returning an
array{object,dict}. What about of adding GetImsIdentities() into
SimManager API?

--Pekka

-- =

Pekka.Pessi mail at nokia.com

--===============3265816277969593162==--

