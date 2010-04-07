Content-Type: multipart/mixed; boundary="===============2871660660926764605=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/2] Added SQLite history plugin
Date: Wed, 07 Apr 2010 13:20:47 -0500
Message-ID: <201004071320.47709.denkenz@gmail.com>
In-Reply-To: <n2w359c5481004071109x6378017dia94253542b9e4626@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2871660660926764605==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Niko,

> On Wed, Apr 7, 2010 at 7:55 PM, Denis Kenzior <denkenz@gmail.com> wrote:
> [...]
> =

> >> Yes, anyway I'm thinking about the case when the storage system is
> >> full, or an other error occours while trying to store the message.
> >> In this case the driver should notify the network with a NACK, while a
> >> signal should notify the user that the storage is full or there is
> >> another problem.
> >
> > If your storage is full then you have other problems.  Adding nack/ack
> > capability would increate the complexity of the driver/core about 10
> > fold, so this is not something we're willing to consider right now.  If
> > this is an issue, then the user should be notified well in advance to
> > rectify the situation or face possible data loss.
> =

> That's not always possibile, for example in the case of
> filesystem/block device faults.
> I have a real case here, on the freerunner sometimes using the WiFi
> will broke the access to the SD media card, I know it's not a perfect
> device but similiar problems may happen on different hardware too.
> =

> Anyway I was aware of such complexity, my old phones nacks when the
> sim/me/fs storage is full, hoping that will be addressed in some
> future.

This is certainly possible to add, however the priority is rather low becau=
se =

only truly bizarre conditions result in loss of data.  Namely disk full and =

physical device corruption.  In both cases you have other more important =

information than SMS that will be lost.

If this is important to you, you can always submit a patch :)

Regards,
-Denis

--===============2871660660926764605==--

