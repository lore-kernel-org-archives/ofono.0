Content-Type: multipart/mixed; boundary="===============7908774250886431572=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Alcatel Onetouch X515 support
Date: Thu, 08 Nov 2012 11:29:13 -0600
Message-ID: <509BEBE9.4070908@gmail.com>
In-Reply-To: <CABvLYuBU9h+RJuutiFf3EYaiydj2Rd2MQWKY0u2ZjhdOCGfaBg@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7908774250886431572==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Cedric,

On 11/08/2012 10:43 AM, Cedric Jehasse wrote:
> Hi Denis,
>
>     The SIM busy stuff is tricky.  oFono reads lots of files from the
>     SIM before even checking CPIN.  So you need to check the CPIN SIM
>     busy condition before signaling that the SIM is inserted.  As I
>     said, check how other Qualcomm based devices are doing this.  E.g.
>     Huawei, ZTE, etc.
>
>
> I've checked this, and i think we're talking about different things.
>  From what i understand you're talking about the sim being busy at early
> sim initialization (after enabling the modem it must wait for the sim to
> be ready before notifying the core a sim is inserted).
> I'm talking about the sim being busy right after entering the pin. The
> sim is initialized, and "AT+CPIN?" returns " +CPIN: SIM PIN". Then i
> enter the pin with AT+CPIN=3D"xxxx". Right after this the pin is checked
> with "AT+CPIN?" and now it returns "+CME ERROR: 14".

Ah, I see now.  Yes you are correct.

>
> In at_pin_send_cb i see that for ZTE the state is polled with
>   at_util_sim_state_query_new, i think this also must be done for
> Alcatel. And for huawei this should probably look at ^SIMST.

Yes, the intent is for the gory details to be taken care of by the sim =

atom driver.  Most 'real' phone modems provide an unsolicited =

notification for this.  If the hardware does not provide such a =

notification then you have to poll.  If you can make Huawei work with =

^SIMST, that would be great as well.  It should work similarly to the =

IFX XSIM or the MBM EPEV notification.

Regards,
-Denis

--===============7908774250886431572==--

