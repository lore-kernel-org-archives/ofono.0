Content-Type: multipart/mixed; boundary="===============3888766698194557476=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] plugin: provision: create multiple contexts for multiple
 entries in mbpi
Date: Thu, 12 Mar 2020 09:49:31 -0500
Message-ID: <59c61ecf-9d98-90f2-a2f3-0ec8c09f6843@gmail.com>
In-Reply-To: <b66d4aa0-04ba-8828-8325-d07ffe6955b4@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3888766698194557476==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Tarmo,

> I don't see how am I going to solve this. The end user cannot configure =

> the device (there's no user interaction whatsoever). I could not find =

> the mythical Android database at the time (I do now - it's at =

> https://android.googlesource.com/device/sample/+/master/etc/apns-full-con=
f.xml). =

> It contains many duplicates, because the virtual MNO-s share MCC and =

> MNC-s with the physical ones. That's how the mobile networks are built =

> in the real world. So I was very confused about how to proceed.

MVNOs are handled by utilizing the EFspn file as a differentiator.  So =

even if MNC/MCC is the same, once you include the SPN, the number of =

duplicates goes down drastically.  This is why oFono uses the following =

signature for get_settings:

         int (*get_settings)(const char *mcc, const char *mnc, const =

char *spn,

Once a proper database is used, this mostly goes away as an issue.  We =

did add the SPN field to MBPI schema in the olden days.  The problem is =

that nobody actually updated the MBPI database to take advantage of this.

> =

> Sure, after much, much frustration I arrived to the workaround of =

> manually provisioning APNs (which I stole from mbpi!) for each factory =

> installed SIM through Christophe Ronco's file-provision plugin. This =

> plugin is a life-saver, but it certainly falls short of automatic =

> provisioning. That's the same level of sophistication as pppd. And as =

> extra punishment I have to write a network supervisor which orders =

> connman to actually use the service of a new SIM whenever it is replaced =

> - even if it's from the same MNO. But that's a different rant altogether.
> =

> So, for perspective - saying "mbpi is just not a very good database" =

> helps me none at all when I need to get my widget to go online :) Please =

> handle the duplication, as this is how the mobile networks are built.
> =


I can take a patch that enables duplicates as a config / environmental =

setting.  As long as the default is the old behavior.  But as I =

mentioned previously, ConnMan / oFono were not designed to work this =

way, and so far nobody has been willing to do the work in both projects =

to change that.

Regards,
-Denis
--===============3888766698194557476==--

