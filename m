Content-Type: multipart/mixed; boundary="===============4902408609691573151=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi@remlab.net>
Subject: Re: GPRS support for Ofono
Date: Wed, 02 Sep 2009 13:19:25 +0200
Message-ID: <314552614d224d33fa2c6a24b9b751c8@chewa.net>
In-Reply-To: <1251889385.1266.60.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4902408609691573151==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Wed, 02 Sep 2009 04:03:05 -0700, Marcel Holtmann <marcel@holtmann.org>
wrote:
>> And this generally applies to services that operators have decided to
>> run behind a dedicated APN, such as WAP, MMS, Push over Cellular (PoC)
>> and others. For example, Elisa in Finland seems to be running their
>> MMSC behind an "mms" APN, with public IP address space, but firewalled
>> from the rest of the Internet. oFono should isolate such an access
>> from the rest of the system, since only the MMS client would know how
>> to work with it properly.
> =

> if they are doing something nasty like that, then the only real solution
> is network namespaces. This means we can just bring the interface up and
> then have to give all networking details via D-Bus properties.

Yes. That's what I was saying, or at least trying to say.

-- =

R=C3=A9mi Denis-Courmont


--===============4902408609691573151==--

