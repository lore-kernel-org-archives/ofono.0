Content-Type: multipart/mixed; boundary="===============5856520354815042653=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Alcatel Onetouch X515 support
Date: Thu, 08 Nov 2012 09:10:39 -0600
Message-ID: <509BCB6F.40102@gmail.com>
In-Reply-To: <CABvLYuB6O8xvbaK9LtoYec8i_7x3N1RE5B7+6tjKXDt4+KgRPg@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5856520354815042653==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Cedric,

On 11/08/2012 09:02 AM, Cedric Jehasse wrote:
> Hi Denis,
>
> I've just seen the same issue on a huawei E369. So i'm not so sure
> fixing it in the plugin is the best way.
> What i've done now is reschedule calling __ofono_sim_recheck after 5
> seconds if sim_pin_query_cb get's a CME Error 14.
> Is it ok to do it like this?

The design philosophy is to not perform any polling in the core.  The =

modem driver has to take care of this.

Regards,
-Denis

--===============5856520354815042653==--

