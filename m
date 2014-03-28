Content-Type: multipart/mixed; boundary="===============8021720617254197071=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Problem reconnecting when 3G dongle is re-inserted
Date: Fri, 28 Mar 2014 09:54:00 -0500
Message-ID: <53358D08.4080908@gmail.com>
In-Reply-To: <CAK+sfotnpxuhAOGyH-nD9H0fRzr85g+wnan5d190wPqpSbF7CA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8021720617254197071==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Homam,

There is no top-posting on this mailing list.  Please do not top-post.

On 03/28/2014 09:20 AM, Homam Dabis wrote:
> The issue seems sepcific to the E303 HiLink H-2 model.
> =

> If I do the same thing using the E303 HiLink S-1 model then all is fine.
> =

> Huawei seem to have updated their chipset with the H-2 revision and are
> stopping production of the S-1 revision.
> =

> Cedric: Can you provide me with more details please. =


There was a quirk in certain manufacturer's modems whereby they
forcefully HUPed the modem port when the PPP link was disabled.  That
meant that the port had to be closed and re-opened after every context
activation / deactivation.

This is normally turned off with AT&C0.  Re-opening the modem port is
actually not trivial.  Search the archives / git, there have been
previous attempts at doing this which were abandoned.  The easiest
solution will be to figure out why AT&C0 doesn't work.

Regards,
-Denis


--===============8021720617254197071==--

