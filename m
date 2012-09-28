Content-Type: multipart/mixed; boundary="===============7743610640278036697=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: PinRequired value during sim initialization
Date: Fri, 28 Sep 2012 10:23:35 -0500
Message-ID: <5065C0F7.6000007@gmail.com>
In-Reply-To: <CABvLYuC_TVS+1AcEdbFq4SNXmV0+WLYfESK0ztL3=QRHAa82RA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7743610640278036697==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Cedric,

On 09/28/2012 03:03 AM, Cedric Jehasse wrote:
> Hi,
>
> Immediately after the 'Present' property changes to true on
> org.ofono.SimManager, i read the 'PinRequired' property. Because the
> sim is not yet initialized this is set to "none". It would be nice if
> this was set to "notinitialized", or if there would be an additional
> property to know if sim initialization is done.
>

I do admit this is a slight inconsistency in the API.  However, =

PinRequired=3Dnone was never meant to signify that the SIM has been =

initialized.  If you want that, then you should monitor the =

'SubscriberIdentity' property.  Once that property goes live you can =

assume that the SIM has been initialized to the point that other tasks =

can be performed, e.g. going Online.  If the PIN is required then the =

PinRequired will at some point go to state other than 'none'.

In general oFono does not use 'unknown' states for any properties unless =

that is an explicit state that can be obtained from the network.  The =

best I can suggest right now is that we can make PinRequired an optional =

property; e.g. it will not be present until the PIN has been queried.

Regards,
-Denis

--===============7743610640278036697==--

