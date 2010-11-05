Content-Type: multipart/mixed; boundary="===============0480532536087361764=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] sim: Check SIM pin status after changing pin.
Date: Fri, 05 Nov 2010 15:12:35 -0500
Message-ID: <4CD46533.6090404@gmail.com>
In-Reply-To: <AANLkTimcZCHkLiyiwKOOxnT_kC1cAwS7J=A8-SaeozRg@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0480532536087361764==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marit,

Just a gentle reminder not to top-post on this mailing list.

On 11/05/2010 09:25 AM, Marit Sofie Henriksen wrote:
> Hi Denis.
> OK, I can see that this approach was rather too simplistic... Maybe
> checking the returned CME error would be a better idea?
> I=E2=80=99m a bit unsure how (or if) to proceed with this. As this is in =
the
> core, and not our driver, it might be more on your table? If you think
> it is important.
> =


Well this is definitely something we need to get right.  So feel free to
send a patch to the TODO file adding this task.  The description is
basically what I outlined in my earlier reply.  E.g. if change_pin
fails, we should check PIN state.  If it is anything other than READY,
tear the state back to pre_sim state and set the modem offline.

this task can go through the regular task lifecycle.  If you guys feel
up to it, this is certainly something you can work on / contribute.

Regards,
-Denis

--===============0480532536087361764==--

