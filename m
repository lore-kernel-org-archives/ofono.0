Content-Type: multipart/mixed; boundary="===============8502505315009398957=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: connmand[186]: Online check failed but running dhclient manually
 fixes this issue
Date: Tue, 05 Sep 2017 10:36:40 -0500
Message-ID: <fb4d8953-043f-5844-5590-509f9a4ea973@gmail.com>
In-Reply-To: <20170905164624.290cc274@lazus.yip>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8502505315009398957==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 09/05/2017 09:46 AM, Alexander Couzens wrote:
> On Thu, 10 Aug 2017 12:47:28 +0200
> Daniel Wagner <wagi@monom.org> wrote:
> =

>>>     Bus 001 Device 003: ID 1bc7:1201 Telit Wireless Solutions
>>
>> Here is a compile tested 'fix'. I don't know if this works and\
>> obviously it doesn't follow the coding guide lines for this
>> project. If you could test this and report back the outcome
>> that would be really helpful. Then I can create a proper
>> patch for Denis.
> =

> I can confirm this bug with an quectel ec20 using the firmware
> EC20EQAR02A13E2G  1  [Jul  5 2017 10:49:17].
> =

> To reproduce using ofono w/o connman. linux 4.12.8
> - call ofono "../context1 Active true"
> - set the ip by hand. No ping response.
> - using dhcpcd. Ping responses.
> =

> The `ip addr show` looks the same, except the interface has now an ipv6
> link local address. Is this is problem of modern LTE cards?
> Could be raw-ip or 802.3 encapsulations the problem?
> =


Here's something Reinhard said in a different thread that might be =

applicable here:

"Unfortunately the PLS8 seems to need DHCP to be used as a trigger to
pass IPv4 traffic over the network interface even if the parameters
could be obtained from AT commands.

This restriction also holds for some other Qualcomm firmwares when the
QMI network interface is used in Ethernet mode instead of Raw IP mode."

If this is true, then falling back to DHCP would seem to be required for =

many Qualcomm based devices.  This seems to be a recently introduced =

'bug' as older QMI devices did not need this workaround.

Regards,
-Denis

--===============8502505315009398957==--

