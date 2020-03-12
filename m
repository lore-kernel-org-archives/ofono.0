Content-Type: multipart/mixed; boundary="===============8467533145789508878=="
MIME-Version: 1.0
From: Tarmo Kuuse <tarmo.kuuse@gmail.com>
Subject: Re: [PATCH] plugin: provision: create multiple contexts for multiple
 entries in mbpi
Date: Thu, 12 Mar 2020 15:22:00 +0200
Message-ID: <b66d4aa0-04ba-8828-8325-d07ffe6955b4@gmail.com>
In-Reply-To: <a39210bd-2edb-21dc-7f21-b81a60649745@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8467533145789508878==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 04.03.20 20:49, Denis Kenzior wrote:
>> In my case automatic provisioning always fails:
>> - the database has multiple entries for basically every operator/country
> =

> mbpi is just not a very good database.=C2=A0 It provides lots of duplicat=
es =

> and doesn't distinguish by spn last I checked.=C2=A0 Ubuntu Touch folks u=
sed =

> the android apndb and others used custom ones.=C2=A0 As far as I'm aware, =

> ofono + mbpi was never used in production.=C2=A0 If I'm wrong, I'd love t=
o =

> hear about it.
> =

> I have discouraged the use of mbpi for these reasons.=C2=A0 Not stopping =
you =

> from using it, just pointing out what has been done historically.

As I understand it, ofono is designed to automatically pick the correct =

service provider parameters (primarily APN) for the installed SIM - =

unlike a simple solution like pppd. When arriving to the connman/ofono =

community I found it very difficult getting my widget online when ofono =

refuses to use the ready-to-use mbpi database and authoritative response =

is "mbpi is bad, don't used it".

I don't see how am I going to solve this. The end user cannot configure =

the device (there's no user interaction whatsoever). I could not find =

the mythical Android database at the time (I do now - it's at =

https://android.googlesource.com/device/sample/+/master/etc/apns-full-conf.=
xml). =

It contains many duplicates, because the virtual MNO-s share MCC and =

MNC-s with the physical ones. That's how the mobile networks are built =

in the real world. So I was very confused about how to proceed.

Sure, after much, much frustration I arrived to the workaround of =

manually provisioning APNs (which I stole from mbpi!) for each factory =

installed SIM through Christophe Ronco's file-provision plugin. This =

plugin is a life-saver, but it certainly falls short of automatic =

provisioning. That's the same level of sophistication as pppd. And as =

extra punishment I have to write a network supervisor which orders =

connman to actually use the service of a new SIM whenever it is replaced =

- even if it's from the same MNO. But that's a different rant altogether.

So, for perspective - saying "mbpi is just not a very good database" =

helps me none at all when I need to get my widget to go online :) Please =

handle the duplication, as this is how the mobile networks are built.

-- =

Kind regards,
Tarmo
--===============8467533145789508878==--

