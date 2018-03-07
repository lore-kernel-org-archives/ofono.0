Content-Type: multipart/mixed; boundary="===============5383332548692583250=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 0/3] QMI modem fixups
Date: Wed, 07 Mar 2018 10:31:00 -0600
Message-ID: <feac308f-d5a0-c2df-5879-605cc90ed7f5@gmail.com>
In-Reply-To: <20180307145511.21142-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5383332548692583250==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On 03/07/2018 08:55 AM, Jonas Bonn wrote:
> Here's a couple of fixups to the qmimodem atoms in order handle service
> lifetime.

I've taken the first two patches, but the whole unregister_all thing has =

horrible side-effects since you're force un-registering notifications =

that you don't even own.  Ideally all of QMI core classes need to be =

fixed and handle cancellation of requests properly...

> =

> The QMI services are 'shared' between various atoms and this has some
> subtle problems.  Patch 3, for the LTE atom, handles an issue where
> atoms from different ofono states share an atom.  For things to work
> properly, only atoms from the same state should be sharing a service.

That needs to be fixed.  The initial implementation of QMI assumed that =

a service would only live in a single atom.  There were one or two =

exceptions, hence the shared service stuff was bolted on.  However, =

these assumptions were proven to be false and resulted in lots of issues =

with lifetimes and cleanups.  You're finding this out now.  I believe =

I've commented on how QMI should be fixed before, but I'll take this =

opportunity to do so again :)

> =

> For things to work better, requests should probably be queued on the
> actual service instance that the atom is using and not on the underlying
> shared device queue.  That way, the responses for a destroyed service
> instance could just be dropped instead of being propagated to a
> potentially free'd atom.  This is a rather intrusive rework of the QMI
> core though, so the patches here will need to do for now.

So I would rather fix this cleanly than taking a 100+ line change that =

will be useless, confusing and completely different from the rest of the =

code if stuff inside qmi.c was done properly.  Perhaps an easier =

solution would be to move gprs and radio-settings atoms to post_sim for now?

> =

> The patches here resolve a concrete segfault that arises when the modem
> is set offline.
> =


The proper way of fixing this is to introduce the concept of groups.  So =

that all requests for a particular atom belong to a single group.  That =

way when the atom goes away, the entire group is canceled.  GAtChat does =

this already, take a look at g_at_chat_clone and how various atoms use =

that.  qmi_service might want to follow the same pattern and the shared =

vs non-shared qmi service distinction needs to go away.

Alternatively, you can simply support the group concept directly in the =

API.  Take a look at how drivers/mbimmodem/mbim.c implements =

mbim_device_cancel_group.

Regards,
-Denis

--===============5383332548692583250==--

