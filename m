Content-Type: multipart/mixed; boundary="===============5753332843073962510=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Reg. SMS sent status
Date: Tue, 06 Jul 2010 08:56:34 -0500
Message-ID: <4C333612.9030100@gmail.com>
In-Reply-To: <AANLkTikShPhAsSf73CSkHuRD1GWmZyuEM8GQhnEIMKzl@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5753332843073962510==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Satya,

> How an application notified that SMS is sent status (i.e success or failu=
re) ?

You should really be using the history plugin for this.  You will get
much more information about the message this way.

> =

> Because storage of SMS in some database is application responsibility.
> Once SMS sent status is received according to that application shall
> take an action(status change) on the stored message (i.e. moving SMS
> from OUTBOX to SENTBOX).

Today, oFono returns from the SendMessage call only when the message has
been successfully submitted to the network or the message submission has
failed.

Please note that there is a proposal on the mailing list to change how
the SmsManager interface works.  The interface is likely to change in
the next month or two.

Regards,
-Denis

--===============5753332843073962510==--

