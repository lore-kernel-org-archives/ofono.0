Content-Type: multipart/mixed; boundary="===============5938259357454238048=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/2] Added SQLite history plugin
Date: Wed, 07 Apr 2010 12:55:36 -0500
Message-ID: <201004071255.36407.denkenz@gmail.com>
In-Reply-To: <p2p359c5481004071043id03de442n419b3ff6c39e6c88@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5938259357454238048==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Niko,

> On Wed, Apr 7, 2010 at 7:33 PM, Denis Kenzior <denkenz@gmail.com> wrote:
> [...]
> =

> >> A similar lack of robustness exists at the modem API side as well, if
> >> oFono crashes/runs out of battery after receiving the message from the
> >> modem driver the message is lost. There is no provision in the SMS mod=
em
> >> API to signal back to the modem driver that the message has been
> >> successfully stored on the APE.
> >
> > If oFono crashes/runs out of battery here the driver is gone along with
> > oFono. Notifying it of anything is not going to help ;)
> =

> Yes, anyway I'm thinking about the case when the storage system is
> full, or an other error occours while trying to store the message.
> In this case the driver should notify the network with a NACK, while a
> signal should notify the user that the storage is full or there is
> another problem.

If your storage is full then you have other problems.  Adding nack/ack =

capability would increate the complexity of the driver/core about 10 fold, =
so =

this is not something we're willing to consider right now.  If this is an =

issue, then the user should be notified well in advance to rectify the =

situation or face possible data loss.

Regards,
-Denis

--===============5938259357454238048==--

