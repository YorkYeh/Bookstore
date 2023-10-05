import { Controller } from "@hotwired/stimulus";
import Swal from "sweetalert2";

export default class extends Controller {
  static targets = ["total"];

  add_to_cart(e) {
    const { bookId } = e.target.dataset;
    const { userId } = e.target.dataset;
    const url = "/api/v1/orders/add_to_cart";

    const data = new FormData();
    data.append("book_id", bookId);
    data.append("user_id", userId);

    fetch(url, {
      method: "PATCH",
      body: data,
      headers: {
        "X-CSRF-Token": document.querySelector("meta[name=csrf-token]").content,
      },
    })
      .then((response) => response.json())
      .then((data) => {
        const { amount } = data;
        const count = e.target.closest(".book_order").querySelector(".count");
        count.textContent = Number(count.textContent) + Number(1);

        Swal.fire({
          icon: "success",
          text: data.message,
          toast: true,
          position: "top",
          showConfirmButton: false,
          timer: 3000,
          timerProgressBar: true,
        });

        this.totalTarget.textContent = `小計：＄${amount}元`;
      });
  }

  remove_to_cart(e) {
    const { bookId } = e.target.dataset;
    const { orderId } = e.target.dataset;
    const data = new FormData();
    const url = `/api/v1/orders/${orderId}/remove_to_cart`;
    data.append("book_id", bookId);

    fetch(url, {
      method: "DELETE",
      body: data,
      headers: {
        "X-CSRF-Token": document.querySelector("meta[name=csrf-token]").content,
      },
    })
      .then((response) => response.json())
      .then((data) => {
        const { amount } = data;

        Swal.fire({
          icon: "success",
          text: data.message,
          toast: true,
          position: "top",
          showConfirmButton: false,
          timer: 3000,
          timerProgressBar: true,
        });

        const count = e.target.closest(".book_order").querySelector(".count");
        count.textContent = Number(count.textContent) - Number(1);

        if (count.textContent == 0) {
          e.target.closest(".book_order").classList.add("hidden");
        }

        this.totalTarget.textContent = `小計：＄${amount}元`;
      });
  }

  select_coupon(e) {
    const { orderId } = e.target.dataset;
    const couponId = e.target.value;
    const data = new FormData();
    data.append("coupon_id", couponId);
    const url = `/api/v1/orders/${orderId}/select_coupon`;

    fetch(url, {
      method: "PATCH",
      body: data,
      headers: {
        "X-CSRF-Token": document.querySelector("meta[name=csrf-token]").content,
      },
    })
      .then((response) => response.json())
      .then(({ amount, coupon }) => {
        const selectedOption = e.target.querySelector(
          `option[value="${coupon.id}"]`
        );
        selectedOption.setAttribute("selected", "selected");

        this.totalTarget.textContent = `小計：＄${amount}元`;
      });
  }
}
