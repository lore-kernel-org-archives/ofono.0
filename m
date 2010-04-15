Content-Type: multipart/mixed; boundary="===============5466846220611633846=="
MIME-Version: 1.0
From: Nicola Mfb <nicola.mfb@gmail.com>
Subject: Unreliable next_msg_id (was Re: [PATCH 2/2] Added SQLite history
 plugin)
Date: Thu, 15 Apr 2010 16:02:36 +0200
Message-ID: <p2r359c5481004150702he9dd6211y44d4ac727934102e@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5466846220611633846==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi!

At first look it seems that ofono stores permanently the next_msg_id
only when the "sms_remove" functions is called, and that's does not
happen when ofono quits in a not clean way.

During our tests, users reported bad behaivour of the sqlite history
plugins and error messages about sqlite constraints violation, after a
rude power off of the device (battery drained, forced shutdown with
long press power button, and so on).

That's becouse ofono on the next start reads an "old" next_msg_id from
the permanent storage, so when sending/receiving a new message the
history plugin fails to insert a new row as one with the same msg_id
was already inserted in the prev session.

Any suggestion to fix that?

Finally, we'd like to use some "panic" function in ofono, that should
power down all modems and warn clients when critical conditions
happen.

Is that possible?

Regards

    Niko

--===============5466846220611633846==--

