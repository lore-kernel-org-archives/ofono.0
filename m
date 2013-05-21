Content-Type: multipart/mixed; boundary="===============6105470103863643520=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Telit HE910 : how to get the network interface name
Date: Tue, 21 May 2013 08:17:13 -0500
Message-ID: <519B73D9.7000605@gmail.com>
In-Reply-To: <CAMtf1D-1Hf+zm_tG6JnRsreNFVH6qhwXbUPR0nOVq3iq-e0EaA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6105470103863643520==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Etienne,

On 05/21/2013 05:05 AM, Etienne Mabille wrote:
> Hi everyone,
>
> I am using ofono and the Telit HE910, configured and running fine.
> I am now working on a program thats monitors the connection and
> initiates the reconnection when it is lost.
>
> This program uses the network interface name : usually ppp0.
> I am looking for a clean way of getting this name for the telit, and not
> just hard-code it in case this name changes.
>

The interface name is given by oFono when the context is activated.  See =

the 'Interface' entry in the 'Settings' dictionary of the =

ConnectionContext interface (doc/connman-api.txt)

If the context is deactivated / lost, then the interface is either =

destroyed or ifdown-ed by oFono.

> I see that in several modems (hs0 and samsung at least), this is done in
> the setup_* function in udevng.c
> For these modems, the NetworkInterface field is retrieved from the device.
> However, in the telit documentation, it specifies that out of the seven
> devices created for the modem (/dev/ttyACM0-6)
> only 2 can be used : the data port for ppp connections and the generic
> port for AT commands.
>
> Is there another way of retrieving this information ?
>
> I saw that it appears in gatchat/ppp_net.c: in the function ppp_net_new
> where it submits the name "ppp%d".
> My understanding is that the kernel (or pppd) fills out the number with
> the first one available.
> But this is general code in which we don't have access to the modem
> anyway...
>

Those are implementation details and are subject to change.

> Thanks for your help
> Best regards.
>
> Etienne

Regards,
-Denis


--===============6105470103863643520==--

