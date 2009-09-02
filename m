Content-Type: multipart/mixed; boundary="===============5043420436550005041=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi@remlab.net>
Subject: Re: GPRS support for Ofono
Date: Wed, 02 Sep 2009 11:22:13 +0200
Message-ID: <6e52e431bc7dff6c694e46be9f79b86b@chewa.net>
In-Reply-To: <1251883000.1266.56.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5043420436550005041==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable




On Wed, 02 Sep 2009 02:16:40 -0700, Marcel Holtmann <marcel@holtmann.org>
wrote:
> Hi Remi,
> =

>> > Our current assumption is that the basic setup of IP address, netmask
>> > and broadcast are done by oFono. Only routing and DNS are up to other
>> > programs like ConnMan for example.
>>
>> WHAAAAAAAAAAT? No way. There is just no way.
>>
>> We need to support letting the calling program configure the routing
>> parameters manually. For instance, if we want to connect to multiple
>> primary access points, it simply won't work if Ofono configures
> everything.
>> Instead, we need to either setup source routing or separate network
>> name-spaces. Ofono does not know what the caller intends to do with the
> APN
>> (and should not need to), so it cannot configure IP parameters. Besides,
> it
>> makes very little if any sense to configure IP parameters but not DNS.
> =

> personally I don't care who finally sets the IP for the interface. It
> really just makes no difference. What problem do you see if oFono would
> set the IP address on that newly created interface that is up and
> running now?

Then the application cannot influence the way it's done. That's the whole
point. Maybe I want to migrate the interface in a new namespace. For that,
it must (1) create the interface, (2) migrate it, (3) configure it, in that
order. So Ofono cannot do (3) if it cannot do (2), and it certainly should
not do (2) by itself. So it has to stick to (1).

-- =

R=C3=A9mi Denis-Courmont


--===============5043420436550005041==--

