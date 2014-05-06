Content-Type: multipart/mixed; boundary="===============4910637402548140371=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] sim: Handle multiple invocations of sim_imsi_obtained
Date: Tue, 06 May 2014 15:59:10 -0500
Message-ID: <53694D1E.1000204@gmail.com>
In-Reply-To: <5368F00F.5040609@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4910637402548140371==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Slava,

>>> +    if (sim->imsi && !strcmp(sim->imsi, imsi))
>>> +        return;
>> Calling this function a second time is an error.  So this condition
>> looks highly suspect.  What issue are you trying to address?
> =

> sim_imsi_obtained() is invoked from two places: sim_imsi_cb() and
> sim_efimsi_cb(). sim_imsi_cb() in turn is a completion for

Only one of those functions is called, depending on how the driver
implements obtaining of the IMSI.  Some drivers do not have the ability
to read IMSI using the READ BINARY / READ RECORD SIM commands.

> sim_retrieve_imsi() which is invoked from 5 other asynchronous
> callbacks, mostly triggered by a number of ofono_sim_read() calls. I
> don't claim that I fully understand what's going on and I haven't
> analyzed all the call sequences but it surely is invoked twice in our
> setup. Any suggestions on where the problem might be?

The code flow of the functions deals with Barred / Fixed Dialing Numbers
and the variations between 2G and 3G sims.  The logic is set up in such
a way that sim_retrieve_imsi is called only once.  Looking at the code,
there doesn't seem to be any way for sim_retrieve_imsi to be called twice.

If this is indeed happening, then please let me know under what
circumstances this happens and I can help you track this issue down.

Regards,
-Denis


--===============4910637402548140371==--

