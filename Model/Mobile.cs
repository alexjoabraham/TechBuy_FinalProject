using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TechBuy_FinalProject.Model
{
    public class Mobile
    {
        public string MobileId { get; set; }
        public string Title { get; set; }
        public string Description { get; set; }
        public string BrandId { get; set; }
        public string Image { get; set; }
        public decimal Price { get; set; }
        public int Quantity { get; set; }
    }
}