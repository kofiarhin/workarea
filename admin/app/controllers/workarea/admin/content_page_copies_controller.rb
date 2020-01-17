module Workarea
  module Admin
    class ContentPageCopiesController < Admin::ApplicationController
      required_permissions :store

      before_action :find_source_product

      def new
      end

      def create
        @page_copy =
          CopyPage.new(@page, params[:page].to_unsafe_h).perform

        if @page.persisted?
          flash[:success] = t('workarea.admin.content_page_copies.flash_messages.created')
          redirect_to edit_create_content_page_path(@page, continue: true)
        else
          flash[:error] = t('workarea.admin.content_page_copies.flash_messages.error')
          render :new
        end
      end

      private

      def find_source_product
        return unless params[:source_id].present?
        @page = Content::Page.find_by(slug: params[:source_id])
      end
    end
  end
end
