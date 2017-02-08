Content-Type: multipart/mixed; boundary="===============4969819375691682316=="
MIME-Version: 1.0
From: Christophe Ronco <c.ronco@kerlink.fr>
Subject: provisioning APN using mbpi plugin
Date: Wed, 08 Feb 2017 13:24:42 +0100
Message-ID: <1fdc62d3-5bb4-baec-39f6-ea0345f010ff@kerlink.fr>
In-Reply-To: <d9dfde3c-2b28-197f-f257-a7451d9871ed@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4969819375691682316==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

I used to set APN manually (using DBUS interface) on my modems.

I am now trying to provision APNs using default values (depending on =

operator).
I have installed mobile-broadband-provider-info package and tried to use =

ofono mbpi plugin.
This fail on my current operator:
Feb 8 10:42:16 klk-lpbs-040070 daemon.err ofonod[3750]: =

/usr/share/mobile-broadband-provider-info/serviceproviders.xml:4614 =

Duplicate context detected
Feb 8 10:42:16 klk-lpbs-040070 daemon.warn ofonod[3750]: Provisioning =

failed

Indeed, my operator (Orange, in France) has several APN of type =

"internet" declared in mobile-broadband-provider-info database. This is =

why it fails. And looking at the database, this is quite common.
Allowing duplicates or not is just a parameter in function =

mbpi_lookup_apn. So I changed that in provision_get_settings function =

(plugins/provision.c).

With this change, provisionning using plugins provision.c and mbpi.c =

works. It creates 9 contexts for my SIM, 4 of them are internet type =

contexts.
In connman (I use connman above ofono), I see 4 services and I am able =

to connect at least 2 of them. So I wonder why duplicate context is =

considered an error by these plugins. Does anybody know ?

Christophe

--===============4969819375691682316==--

