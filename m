Content-Type: multipart/mixed; boundary="===============0430109562696257510=="
MIME-Version: 1.0
From: Li, Zhigang <zhigang.li@intel.com>
Subject: RE: [PATCH] Enable hs 2330 MBM modem
Date: Wed, 23 Feb 2011 16:50:26 +0800
Message-ID: <B32E3D5F1713054290B4FF257B89C51A29FA8D5B06@shsmsx502.ccr.corp.intel.com>
In-Reply-To: <B32E3D5F1713054290B4FF257B89C51A29E8E95640@shsmsx502.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0430109562696257510==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

Base on your request, I get the lsusb -v result, according the interface re=
sult, the "Data Modem" is ok, besides, my test result also ok.
In fact, I tried "Module Data Modem", "Broadband Module Data Modem" all are=
 don't work.


> looks wrong to me. Please get the lsusb -v out for this modem where it
> lists the interface strings.

Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         2 Communications
      bInterfaceSubClass      2 Abstract (modem)
      bInterfaceProtocol      1 AT-commands (v.25ter)
      iInterface              6 HP hs2330 Mobile Broadband Module| Data Mod=
em
      CDC Header:
        bcdCDC               1.10
      CDC Union:
        bMasterInterface        1
        bSlaveInterface         2 =

      CDC Call Management:
        bmCapabilities       0x03
          call management
          use DataInterface
        bDataInterface          2
      CDC ACM:
        bmCapabilities       0x07
          sends break
          line coding and serial state
          get/set/clear comm features
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x8a  EP 10 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0010  1x 16 bytes
        bInterval               8
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass        10 CDC Data
      bInterfaceSubClass      0 Unused
      bInterfaceProtocol      0 =

      iInterface              7 HP hs2330 Mobile Broadband Module| Data Mod=
em
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x01  EP 1 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0200  1x 512 bytes
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0200  1x 512 bytes
        bInterval               0

thanks
zhigang


--===============0430109562696257510==--

